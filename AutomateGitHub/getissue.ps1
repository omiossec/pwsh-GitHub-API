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
    $issueNumber
)

$authenticationToken = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$accessToken"))
    $headers = @{
        "Authorization" = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"  = "application/json"
    }


    $reposAPIUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)"

    $githubIssue = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 


$githubIssue