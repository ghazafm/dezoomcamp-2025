resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDa++X0QRzg1eRH8d42H2UhHVwggs7D17+OIiryDSA4l fauzanghaza@MacBookAir"
}