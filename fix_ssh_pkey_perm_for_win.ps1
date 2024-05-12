(Get-ChildItem -filter 'private_key' -recurse -path .\.vagrant).FullName | % {
  icacls $_ /inheritance:r
  icacls $_ /grant:r *S-1-3-0:F
}