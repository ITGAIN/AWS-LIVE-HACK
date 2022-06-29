# Einblick in einen AWS-Penetrationtest

## Ablauf zum erstellen des Szenarios

1. Erstellen eines Profils zum deployen der Ressourcen <br>
``` aws configure ```
2. Mit Terraform einen Plan erstellen <br>
3. Die #FIXME in der main.tf un der ec2.tf ändern!
``` terraform plan -out terraform.plan ``` 
4. Mit Terraform den Plan ausführen <br>
``` terraform apply terraform.plan ``` 
5. Um auf die EC2-Instanz zugreifen zu können muss sind folgende Schritte notwendig.
   1. Ein Internegateway muss dem Subnet der Instanz hinzugefügt werden.
   2. Der EC2-Instanz muss eine öffentliche IP-Adresse zugewiesen werden.
   3. Der Routingtabelle muss ein Eintrag zu dem Gateway hinzugefügt werden.
6. Für das Szenario muss noch netcat auf der EC2 installiert werden. <br>
   ``` sudo apt install nc ```
7. Los gehts!

Tipps & Tricks:<br>
Das Secret des Benutzer Bob kann über die CLI wie folgt abgefragt werden.<br>
``` terraform output bob_secret ```

Die Lösung steht in der attack_commands.md!

Mehr Informationen zum Ablauf des Szenarios sind im ITGAIN Blog zu finden.<br>
https://www.itgain-consulting.de/blog/einblick-einen-aws-penetrationstest