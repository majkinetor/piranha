Start-PodeServer -Threads 5 {

    # listen
    Add-PodeEndpoint -Address * -Port 8090 -Protocol Http

    # request for web page
    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
        $x = Get-Random 12
        1..10 | % { sleep 1; Out-PodeHost "$x :  $_" }
    }

    # broadcast a received message back out to ever connected client via websockets

}