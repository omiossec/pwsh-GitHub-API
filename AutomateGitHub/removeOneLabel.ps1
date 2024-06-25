param(
    # The access token to the GitHub Rest API 
    [Parameter(Mandatory=$true)]
    [string]
    $accessToken, 

    [Parameter(Mandatory=$true)]
    [string]
    $orgaName, 

    [Parameter(Mandatory=$true)]
    [string]
    $reposName,
    
    [Parameter(Mandatory=$true)]
    [int]
    $issueNumber,

    [Parameter(Mandatory=$true)]
    [string]
    $issueLabelName

)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
        "Accept"        = "application/vnd.github+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
    }

$issueLabelsURI = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/labels/$($issueLabelName)"

$githubIssueLabels = Invoke-RestMethod -Method DELETE -Uri $issueLabelsURI -Headers $headers -body $body

$githubIssueLabels