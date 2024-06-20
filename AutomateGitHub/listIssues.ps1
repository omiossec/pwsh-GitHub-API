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
# Querry the API to list all issues in a repository
$reposAPIUri = "https://api.github.com/repos/$($organisation)/$($repository)/issues"


$githubIssues = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 

$issuesObject = ConvertFrom-Json($issuesList.content)


foreach ($issue in $issuesObject) { 
    $issue.title 
}
