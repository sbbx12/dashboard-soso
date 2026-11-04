// Fonction Supabase « ical » : récupère l'agenda Google (adresse secrète iCal) pour le Carnet.
// Google n'autorise pas un site à lire cette adresse directement : cette fonction sert de relais.
// Seule une personne connectée au Carnet peut l'appeler (vérification du jeton Supabase activée).
const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });
  try {
    const { url } = await req.json();
    const u = new URL(String(url || ""));
    if (u.protocol !== "https:" || u.hostname !== "calendar.google.com" || !u.pathname.startsWith("/calendar/ical/")) {
      return new Response("Adresse refusée : il faut l'adresse iCal de Google Agenda.", { status: 400, headers: CORS });
    }
    const r = await fetch(u.toString(), { redirect: "follow" });
    if (!r.ok) return new Response(`Google a répondu ${r.status}. Vérifie l'adresse iCal.`, { status: 502, headers: CORS });
    const txt = await r.text();
    return new Response(txt, { headers: { ...CORS, "Content-Type": "text/plain; charset=utf-8", "Cache-Control": "no-store" } });
  } catch (e) {
    return new Response("Erreur : " + String(e).slice(0, 200), { status: 500, headers: CORS });
  }
});
