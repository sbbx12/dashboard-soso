# Carnet de Solène — mise en ligne

1. Supabase : crée le projet, exécute le script `supabase.sql` dans SQL Editor, puis désactive « Confirm email » (Authentication › Sign In / Providers › Email).
2. Ouvre `config.js` et remplace SUPABASE_URL et SUPABASE_ANON_KEY par les valeurs de Project Settings › API (Project URL et clé anon public). Jamais la clé service_role.
3. GitHub : nouveau dépôt public « carnet » › Add file › Upload files › glisse tous les fichiers de ce dossier › Commit changes.
4. Settings › Pages › Source : Deploy from a branch › branche main, dossier / (root) › Save. Après 1 à 2 minutes, le site est à https://TON-PSEUDO.github.io/carnet/
5. Ouvre le site, clique « Créer mon compte » (e-mail + mot de passe). Puis, dans Supabase › Authentication › Sign In / Providers, désactive « Allow new users to sign up » pour que personne d'autre ne puisse créer de compte.
6. Récupère tes données : sur ta page Claude › Réglages › « Sauvegarde seule (.json) », puis sur le site › Réglages › « Choisir un fichier .json ».
7. Sur le téléphone : ouvre l'adresse du site › Partager (ou menu ⋮) › « Sur l'écran d'accueil ».

Mettre à jour plus tard : remplace `index.html` dans le dépôt (Add file › Upload files) par la nouvelle version.
