APNS...

1. You must create PEM files from your APNS certificate and load them in...

?? WHen should the configuration happen?


1. Configure

2. Check for pid? if pid does not exist start the daemon.




TODO: Limit size of the message...

N.B. this is not the enhanced form of the message.






# link to creating a .pem file from cert.


APPLE (https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ProvisioningDevelopment.html)

Installing the SSL Certificate and Key on the Server
You should install the SSL distribution certificate and private cryptographic key you obtained earlier on the server computer on which the provider code runs and from which it connects with the development or production versions of APNs. To do so, complete the following steps:

Open Keychain Access utility and click the My Certificates category in the left pane.
Find the certificate you want to install and disclose its contents.
You'll see both a certificate and a private key.

Select both the certificate and key, choose File > Export Items, and export them as a Personal Information Exchange (.p12) file.
Servers implemented in languages such as Ruby and Perl often are better able to deal with certificates in the Personal Information Exchange format. To convert the certificate to this format, complete the following steps:
In KeyChain Access, select the certificate and choose File > Export Items. Select the Personal Information Exchange (.p12) option, select a save location, and click Save.
Launch the Terminal application and enter the following command after the prompt:
openssl pkcs12 -in CertificateName.p12 -out CertificateName.pem -nodes

Copy the .pem certificate to the new computer and install it in the appropriate place.