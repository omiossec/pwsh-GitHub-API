$GH_TOKEN

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$GH_TOKEN"))
    $headers = @{
        "Authorization" = "Authorization: Bearer $($authenticationToken)"
        Accept="application/vnd.github+json"
        "X-GitHub-Api-Version" = "2022-11-28"
    }

    $headers

$reposAPIUri = "https://api.github.com/repos/omiossec/pwsh-GitHub-API/issues"

$githubRepositories = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 

foreach ($respository in $githubRepositories) {
    write-host  $respository.name
}