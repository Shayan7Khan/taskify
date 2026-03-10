import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  try {
    const { device_token, device_id, title, body, task_id } = await req.json();

    const serviceAccount = JSON.parse(Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!);
    const token = await getAccessToken(serviceAccount);

    const projectId = serviceAccount.project_id;
    const fcmUrl = `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`;

    const response = await fetch(fcmUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`,
      },
      body: JSON.stringify({
        message: {
          token: device_token,
          notification: {
            title: title,
            body: body,
          },
          data: {
            task_id: task_id,
            title: title,
            body: body,
          },
          android: {
            priority: "high",
            notification: {
              channel_id: "task_reminders",
              default_sound: true,
              notification_priority: "PRIORITY_MAX",
            },
          },
        },
      }),
    });

    const result = await response.json();
    console.log("FCM Response:", JSON.stringify(result));

    if (result.error?.details?.[0]?.errorCode === "UNREGISTERED") {
      console.log("Token unregistered, deleting from DB:", device_id);
      const supabase = createClient(
        Deno.env.get("DB_URL")!,
        Deno.env.get("DB_SERVICE_KEY")!
      );
      await supabase.from("user_devices").delete().eq("id", device_id);
    }

    return new Response(JSON.stringify(result), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    });

  } catch (error) {
    console.error("Error:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { "Content-Type": "application/json" },
      status: 500,
    });
  }
});

async function getAccessToken(serviceAccount: any): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = btoa(JSON.stringify({ alg: "RS256", typ: "JWT" }));
  const payload = btoa(JSON.stringify({
    iss: serviceAccount.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: serviceAccount.token_uri,
    exp: now + 3600,
    iat: now,
  }));
  const privateKey = await importPrivateKey(serviceAccount.private_key);
  const signature = await signJWT(`${header}.${payload}`, privateKey);
  const jwt = `${header}.${payload}.${signature}`;
  const tokenResponse = await fetch(serviceAccount.token_uri, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  });
  const tokenData = await tokenResponse.json();
  return tokenData.access_token;
}

async function importPrivateKey(pem: string): Promise<CryptoKey> {
  const pemContents = pem
    .replace("-----BEGIN PRIVATE KEY-----", "")
    .replace("-----END PRIVATE KEY-----", "")
    .replace(/\n/g, "");
  const binaryDer = Uint8Array.from(atob(pemContents), (c) => c.charCodeAt(0));
  return await crypto.subtle.importKey(
    "pkcs8",
    binaryDer,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );
}

async function signJWT(input: string, key: CryptoKey): Promise<string> {
  const encoder = new TextEncoder();
  const data = encoder.encode(input);
  const signature = await crypto.subtle.sign("RSASSA-PKCS1-v1_5", key, data);
  return btoa(String.fromCharCode(...new Uint8Array(signature)))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=/g, "");
}