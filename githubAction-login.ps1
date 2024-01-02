$stringTokken = $Env:GH_TOKEN

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$stringTokken"))
    $headers = @{
        "Accept" = "application/vnd.github+json"
        "Authorization" = "Bearer $authenticationToken"
    }

    $headers

$reposAPIUri = "https://api.github.com/repos/omiossec/pwsh-GitHub-API/issues"

$githubRepositories = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 

foreach ($respository in $githubRepositories) {
    write-host  $respository.name
}