

Initialize terraform
```
$ terraform init
```

Preview changes
```
$ terraform plan -var="bucket=my-bucket" -var="pgp_key_path=/path/to/public/key"
```

Apply changes
```
$ terraform apply
```


## More about your public key

https://menendezjaume.com/post/gpg-encrypt-terraform-secrets/

```
$ gpg --export <email>
```

and then to read secret key
```
$ GPG_TTY=$(tty) terraform output iam_access_key_secret | tr -d '"' | base64 --decode | gpg --decrypt
```
