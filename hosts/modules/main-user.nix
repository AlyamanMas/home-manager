{
  username,
  ...
}:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "Alyaman Massarani";
    extraGroups = [ "wheel" ];
  };
}
