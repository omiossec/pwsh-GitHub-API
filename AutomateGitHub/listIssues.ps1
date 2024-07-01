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
    $reposName 
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
        "X-GitHub-Api-Version"  = "2022-11-28"
    }

# Querry the API to list all issues in a repository
$reposAPIUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues"


$githubIssues = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 

$githubIssues.getType()

$githubIssues | Get-member

foreach ($issue in $githubIssues) { 
    $issue.title 
    $issue.Id
    $issue.created_at.dateTime
    $issue.locked
    $issue.State
    $issue.user.login
    $issue.number
}

#$issuesObject = ConvertFrom-Json($githubIssues)

<#
foreach ($issue in $issuesObject) { 
    $issue.title 
}
#>