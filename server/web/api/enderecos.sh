#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"


"$SERVER/administracao/enderecos-servicos.sh" | awk '

/=== TAILSCALE ===/ {
    modo="TAILSCALE"
}


/File Browser/ {

    getline

    if ($0 ~ /^http/) {

        if (modo == "TAILSCALE")
            print "TAILSCALE_FILEBROWSER="$0
        else
            print "LOCAL_FILEBROWSER="$0

    }

}


/Jellyfin/ {

    getline

    if ($0 ~ /^http/) {

        if (modo == "TAILSCALE")
            print "TAILSCALE_JELLYFIN="$0
        else
            print "LOCAL_JELLYFIN="$0

    }

}


/Transmission/ {

    getline

    if ($0 ~ /^http/) {

        if (modo == "TAILSCALE")
            print "TAILSCALE_TRANSMISSION="$0
        else
            print "LOCAL_TRANSMISSION="$0

    }

}


/Dashboard Web/ {

    getline

    if ($0 ~ /^http/) {

        if (modo == "TAILSCALE")
            print "TAILSCALE_DASHBOARD="$0
        else
            print "LOCAL_DASHBOARD="$0

    }

}

'
