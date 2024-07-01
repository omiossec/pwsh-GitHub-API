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
    # the body of the comment
    [Parameter(Mandatory=$true)]
    [string]
    $commentBody,
    # The issue number
    [Parameter(Mandatory=$true)]
    [int]
    $issueNumber
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    
$headers = @{
        "Authorization"         = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"          = "application/json"
        "Accept"                = "application/vnd.github+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
}

$body = @{  "body"= $commentBody} | ConvertTo-Json   

$issueCommentsURI = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/comments"

$githubCreateIssueComments = Invoke-RestMethod -Method POST -Uri $issueCommentsURI -Headers $headers -body $body

$githubCreateIssueComments