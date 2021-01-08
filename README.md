

Initialize terraform
```
$ terraform init
```

Apply [or preview] changes
```
$ terraform apply [or plan] -var="bucket=my-bucket" -var="pgp_key_path=/path/to/public/key"
```

Instead of specifying variables as arguments you can bundle them in a file
```
$ terraform apply -var-file example.tfvars -auto-approve
```

And to get rid of all resources:
```
$ terraform destroy -var-file example.tfvars
```



## More about your public key

Get your public key
```
$ gpg --export <email> > /path/to/public/key
```

After `apply`, you can access the secret
```
$ export GPG_TTY=$(tty)
$ terraform output iam_access_key_secret | tr -d '"' | base64 --decode | gpg --decrypt
```


If you don't have keys, you can follow [github guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-gpg-key)


Resource:
    - https://menendezjaume.com/post/gpg-encrypt-terraform-secrets/
    - https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/
    - https://unix.stackexchange.com/questions/382279/gpg-hangs-when-private-keys-are-accessed#432468
