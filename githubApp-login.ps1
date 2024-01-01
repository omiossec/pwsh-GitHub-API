# This script illustrate how you can login in and perfrom a get action to Github Rest API with a GitHub App 
# this script list all issues 

param(
    # The access token to the GitHub Rest API 
    [Parameter(Mandatory=$true)]
    [string]
    $pathToGitHubAppKey, 

    [Parameter(Mandatory=$true)]
    [string]
    $instanceID, 

    [Parameter(Mandatory=$true)]
    [string]
    $clientID, 

    [Parameter(Mandatory=$true)]
    [string]
    $organisation, 

    [Parameter(Mandatory=$true)]
    [string]
    $repository
)



# Get the private key content
$apiPemData = Get-Content -Path $pathToGitHubAppKey
$apiSecret = [System.Text.Encoding]::UTF8.GetBytes($apiPemData)


$exp = [int][double]::parse((Get-Date -Date $((Get-Date).addseconds(300).ToUniversalTime()) -UFormat %s)) 
$iat = [int][double]::parse((Get-Date -Date $((Get-Date).ToUniversalTime()) -UFormat %s)) 

# create a Json Web Tokken using new-jwt from the powershell-jwt module
$jwt = New-JWT -Algorithm "RS256" -Issuer $clientID -ExpiryTimestamp $exp -SecretKey $apiSecret -PayloadClaims @{ "iat" = $iat}

# request a new tokken 
$headers = @{
    "Accept" = "application/vnd.github+json"
    "Authorization" = "Bearer $jwt"
}

$res = Invoke-WebRequest -Uri "https://api.github.com/app/installations/$($instanceID)/access_tokens" -Headers $headers -Method Post
$json_res = ConvertFrom-Json($res.Content)
$token = $json_res.token

 
# Querry the API to list all issues in a repository
$reposAPIUri = "https://api.github.com/repos/$($organisation)/$($repository)/issues"


$headers = @{
    Accept="application/vnd.github+json"
    Authorization="token $token"
    "X-GitHub-Api-Version" = "2022-11-28"
}
$issuesList = Invoke-WebRequest -Uri $reposAPIUri  -Headers $headers

$issuesObject = ConvertFrom-Json($issuesList.content)


foreach ($issue in $issuesObject) { 
    $issue.title 
}