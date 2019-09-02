provisioner "remote-exec" {
    inline = [ # I prefer to define the inline commands as an array even if it's just one command.
        "apt-get -qq install python -y",
    ]

    connection {
        host        = "${self.ipv4_address}" # The `self` variable is like `this` in many programming languages
        type        = "ssh"                  # in this case, `self` is the resource (the server).
        user        = "root"
        private_key = "${file('~/.ssh/id_rsa')}"
    }
}
