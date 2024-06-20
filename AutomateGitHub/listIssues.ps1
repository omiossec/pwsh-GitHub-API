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
    $reposName 
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
    }
# Querry the API to list all issues in a repository
$reposAPIUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues"


$githubIssues = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 



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