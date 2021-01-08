

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

Get your public key
```
$ gpg --export <email> > /path/to/public/key
```

After `apply`, you can access the secret
```
$ terraform output iam_access_key_secret | tr -d '"' | base64 --decode | gpg --decrypt
```


If you don't have keys, you can follow [github guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-gpg-key)


Resource:
    - https://menendezjaume.com/post/gpg-encrypt-terraform-secrets/
    - https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/
    - https://unix.stackexchange.com/questions/382279/gpg-hangs-when-private-keys-are-accessed#432468
