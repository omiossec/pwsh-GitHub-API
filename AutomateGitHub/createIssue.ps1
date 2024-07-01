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
    # the tittle of the Issue
    [Parameter(Mandatory=$true)]
    [string]
    $issueTitle, 
    # the body of the issue
    [Parameter(Mandatory=$true)]
    [string]
    $issueBody
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    
$headers = @{
        "Authorization"         = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"          = "application/json"
        "Accept"                = "application/vnd.github+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
}

$issueCreationUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues"

$body = @{ "title" = $issueTitle; "body"= $issueBody} | ConvertTo-Json   

$githubIssueLabels = Invoke-RestMethod -Method post -Uri $issueCreationUri -Headers $headers -body $body

$githubIssueLabels