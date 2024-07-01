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
    $issueNumber,
    # The lock reason
    [Parameter(Mandatory=$true)]
    [string]
    [ValidateSet("off-topic",
        "too heated",
        "resolved",
        "spaqm")]
    $lockReason
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
        "Accept"        = "application/vnd.github+json"
    }

$body = @{ "lock_reason" = $lockReason} | ConvertTo-Json   

$issueURI = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/lock"

Invoke-RestMethod -Method put -Uri $issueURI -Headers $headers -body $body
