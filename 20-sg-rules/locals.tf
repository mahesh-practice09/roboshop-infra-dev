locals {
    my_ip = chomp(data.http.my_public_ip.response_body)
}

