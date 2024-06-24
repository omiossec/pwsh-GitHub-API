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
        "Authorization"         = [String]::Format("Basic {0}", $authenticationToken)
        "Content-Type"          = "application/json"
        "Accept"                = "application/vnd.github.full+json"
        "X-GitHub-Api-Version"  = "2022-11-28"
    }


    <#
    Accept 
    application/vnd.github.text+json Text representation comments

    application/vnd.github.raw+json raw markdown

    application/vnd.github.html+json HTML representation

    application/vnd.github.full+json return the 3 in body (Markdown) body_html (HTML) and body_text
    #>

    $reposAPIUri = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/comments"

    $githubIssue = Invoke-RestMethod -Method get -Uri $reposAPIUri -Headers $headers 


    $githubIssue