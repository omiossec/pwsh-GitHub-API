param(
    # The access token to the GitHub Rest API 
    [Parameter(Mandatory=$true)]
    [string]
    $accessToken, 
    # The repository Name
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
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
        "Accept"        = "application/vnd.github+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
    }
    
$issueURI = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/labels"

$githubIssueLabels = Invoke-RestMethod -Method get -Uri $issueURI -Headers $headers

foreach ($label in $githubIssueLabels) {
    $label.name
    $label.description
    $label.default
}