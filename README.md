# What is PHPNgk
PHPNgk is a bash script that automates opening a file on a local **PHP** server and sharing it through **Ngrok**. Plus, it can create a **QR** of the Ngrok link using `qrencode`. 

It's use is primary focused on students (like me) who are working with quick, regular assignments, which are being opened, closed and sended to revision through Ngrok on a daily basis.

# Installation
Clone the repo and run `setup.sh` as **sudo**. At some point it will ask you to enter your **Ngrok Authtoken** (found in the [ngrok website](https://ngrok.com/)), paste it and you are ready to go.

If you don't want to copy the script to the $PATH (/usr/bin), comment the corresponding function at the end of the script.
# Usage
**Standard**: pass a file as first arg to open it with local PHP on browser and port:

    phpngk index.php

**-n**: turns on ngrok. The link generated is opened on browser, shown on console and copied to your clipboard.

**-nq**: turns on ngrok, show the link, copies it to your clipboard and generate a qr code in current dir. Automatically opened with `feh`.

**-h** | **--help**: shows this menu.

**-c** | **--config**: opens the script in `nano`.

Also:
- Default browser is Firefox. Google Chrome is also supported (comment and uncoment variable on script).
- Default PHP path is local (`php` command).
- Default port to open PHP and Ngrok is 8080.
