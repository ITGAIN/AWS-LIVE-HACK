# Einblick in einen AWS-Penetrationtest

## Ablauf zum erstellen des Szenarios

1. Erstellen eines Profils zum deployen der Ressourcen <br>
``` aws configure ```
2. Anpassen der main.tf im Ordner terraform
3. Mit Terraform einen Plan erstellen <br>
``` terraform plan -out terraform.plan ``` 
4. Mit Terraform den Plan ausführen <br>
``` terraform apply terraform.plan ``` 
5. Los gehts! 
Die Lösung steht in der attack_commands.md!
