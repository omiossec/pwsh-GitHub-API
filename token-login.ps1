# This script illustrate how you can login in and perfrom a get action to Github Rest API with an access token 
# this script list all respositoris name for a given 

param(
    # The access token to the GitHub Rest API 
    [Parameter(Mandatory=$true)]
    [string]
    $accessToken, 


    [Parameter(Mandatory=$true)]
    [string]
    $orgaName
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
    }

$reposAPIUri = "https://api.github.com/orgs/$($orgaName)/repos"

$githubRepositories = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 

foreach ($respository in $githubRepositories) {
    write-host  $respository.name
}