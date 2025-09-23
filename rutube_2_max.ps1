# === Настройки RuTube ===
$ChannelId = "##########"              # ID канала RuTube
$MaxVideos = 2                         # Берём только 2 ролика
$FilterDate = ""                       # Можно ограничить по дате (YYYY-MM-DD)
$OutFileLinks = "c:\Max\rutube_links.txt"
$OutFileTitlesLinks = "c:\Max\rutube_titles_links.txt"
$OutFileExcel = "c:\Max\rutube_for_excel.csv"

# === Настройки Green API (MAX) ===
$apiUrl = "https://3100.api.green-api.com/v3"
$idInstance = "##########"         # проставьте ваш idInstance изи API
$apiToken = "####################" # проставьте свой apiToken
$chatId = "phone_number@c.us"      # твой личный чат

# === Сбор роликов RuTube ===
$resultsLinks = @()
$resultsTitlesLinks = @()
$resultsExcel = @()
$page = 1

Write-Host "Запрашиваю последние $MaxVideos роликов канала $ChannelId ..."

while ($resultsLinks.Count -lt $MaxVideos) {
    $url = "https://rutube.ru/api/video/person/$ChannelId/?page=$page"

    try {
        $json = Invoke-RestMethod -Uri $url -ErrorAction Stop
    } catch {
        Write-Error "Ошибка при запросе API RuTube: $_"
        break
    }

    if (-not $json.results) { break }

    foreach ($video in $json.results) {
        $created = [DateTime]::Parse($video.created_ts)
        if ($FilterDate -ne "" -and $created -lt [DateTime]$FilterDate) { continue }

        $link = "https://rutube.ru/video/$($video.id)/"
        $title = $video.title

        $resultsLinks += $link
        $resultsTitlesLinks += "$title — $link"
        $resultsExcel += '"' + $title.Replace('"','""') + '";"' + $link + '"'

        if ($resultsLinks.Count -ge $MaxVideos) { break }
    }

    if (-not $json.has_next) { break }
    $page++
}

# === Сохранение файлов ===
if ($resultsLinks.Count -eq 0) {
    Write-Warning "Не найдено ни одного видео."
    exit
}

$resultsLinks | Out-File -FilePath $OutFileLinks -Encoding UTF8
$resultsTitlesLinks | Out-File -FilePath $OutFileTitlesLinks -Encoding UTF8
$resultsExcel | Out-File -FilePath $OutFileExcel -Encoding UTF8

Write-Host "Сохранено $($resultsLinks.Count) ссылок в $OutFileLinks"
Write-Host "Сохранено $($resultsTitlesLinks.Count) названий + ссылок в $OutFileTitlesLinks"
Write-Host "Сохранено $($resultsExcel.Count) строк для Excel в $OutFileExcel"

# === Отправка сообщений в MAX ===
$sendUrl = "$apiUrl/waInstance$idInstance/SendMessage/$apiToken"

foreach ($i in 0..($resultsLinks.Count - 1)) {
    $messageText = $resultsTitlesLinks[$i]
    $body = @{
        chatId = $chatId
        message = $messageText
    } | ConvertTo-Json -Depth 10 -Compress

    try {
        $response = Invoke-RestMethod -Uri $sendUrl -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($body)) -ContentType "application/json; charset=utf-8"
        Write-Host "Отправлено: $messageText — idMessage: $($response.idMessage)"
    } catch {
        Write-Error "Ошибка при отправке: $_"
    }
}
