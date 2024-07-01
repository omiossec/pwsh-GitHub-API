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
    # The issue number
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

    $issueCommentsURI = "https://api.github.com/repos/$($orgaName)/$($reposName)/issues/$($issueNumber)/comments"

    $githubIssueComments = Invoke-RestMethod -Method get -Uri $issueCommentsURI -Headers $headers 


    foreach ($comment in $githubIssueComments){
        $comment.body
        $comment.id
        $comment.user.login
        $comment.url
        $comment.reactions.total_count
    }