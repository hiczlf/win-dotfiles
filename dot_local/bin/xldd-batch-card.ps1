<#
.SYNOPSIS
批量创建 XLDD 卡密并输出名称和卡密文本。
.DESCRIPTION
使用脚本中配置的 XLDD_ADMIN_TOKEN 管理员令牌。
分类 ID：freepin_1m=39、freepik_3m=40、freepik_1w=45、
freepik_1m_100=46、vecteezy_1m=53、motionarray_1m=54。
.EXAMPLE
xldd-batch-card.ps1 -CardCategoryId 53 -Count 5
.EXAMPLE
xldd-batch-card.ps1 53 5
#>

#Requires -Version 7.0
[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$CardCategoryId,

    [Parameter(Mandatory, Position = 1)]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Count
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$XLDD_ADMIN_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImxmQHFxLmNvbSIsInN1YiI6NTExOTUsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc3OTk1OTgxNSwiZXhwIjoxODA1ODc5ODE1fQ.FPAmIAz6UM83XGNQd7R584Zl4g1LMMYFBH1g9M_lXd8'

if ([string]::IsNullOrWhiteSpace($XLDD_ADMIN_TOKEN)) {
    throw '请先设置脚本中的 XLDD_ADMIN_TOKEN。'
}

$request = @{
    Uri = 'https://aadmin.ixling.com/api/admin/card/batch-create'
    Method = 'Post'
    Headers = @{ Authorization = "Bearer $XLDD_ADMIN_TOKEN" }
    ContentType = 'application/json'
    Body = (@{
        cardCategoryId = $CardCategoryId
        shopId = 1
        count = $Count
        distribution = 'taobao'
    } | ConvertTo-Json -Compress)
    TimeoutSec = 60
}

try {
    $response = Invoke-RestMethod @request
}
catch {
    throw '创建请求未能正常完成，结果可能尚未确认。请检查网络、令牌及后台记录，确认后再重试，避免重复创建。'
}

try {
    $firstName = $response.data.list[0].name
    $cardsString = $response.data.cardsString
    if ([string]::IsNullOrWhiteSpace($firstName) -or
        [string]::IsNullOrWhiteSpace($cardsString)) {
        throw '缺少名称或卡密文本。'
    }
}
catch {
    throw '接口响应缺少有效的 data.list[0].name 或 data.cardsString。请检查后台记录后再重试，避免重复创建。'
}

Write-Output "${firstName}:"
Write-Output ''
Write-Output $cardsString
