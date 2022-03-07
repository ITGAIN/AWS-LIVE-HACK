# Einblick in einen AWS-Penetrationtest

## Ablauf zum erstellen des Szenarios

1. Erstellen eines Profils zum deployen der Ressourcen <br>
``` aws configure ```
2. Mit Terraform einen Plan erstellen <br>
``` terraform plan -out terraform.plan ``` 
3. Mit Terraform den Plan ausführen <br>
``` terraform apply terraform.plan ``` 
4. Los gehts! 
Die Lösung steht in der attack_commands.md!