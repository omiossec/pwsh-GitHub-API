param(
    # The access token to the GitHub Rest API 
    [Parameter(Mandatory=$true)]
    [string]
    $accessToken, 
    # The Organisation name
    [Parameter(Mandatory=$true)]
    [string]
    $orgaName, 
    # The repository Name
    [Parameter(Mandatory=$true)]
    [string]
    $reposName,
    # The issue number
    [Parameter(Mandatory=$true)]
    [int]
    $issueNumber
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization"         = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"          = "application/json"
        "Accept"                = "application/vnd.github.text+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
    }

$issueIUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)"

$githubIssue = Invoke-RestMethod -Method get -Uri $issueIUri -Headers $headers 

$githubIssue