# Detect the current system language
$CurrentCulture = (Get-WinUserLanguageList)[0].LanguageTag

# Ensure English (United States) is the first language in the system
$languages = Get-WinUserLanguageList
$enUS = $languages | Where-Object LanguageTag -eq "en-US"

if ($enUS) {
    # Move English (United States) to the first position if already installed
    $languages.Remove($enUS)
    $languages.Insert(0, $enUS)
} else {
    # Add English (United States) if it is not present
    $languages.Add((New-WinUserLanguageList -LanguageTag "en-US"))
}

Set-WinUserLanguageList $languages -Force
Write-Output "The primary language has been changed to English (United States)."

# Change the current input method to English (United States)
$inputMethod = "0409:00000409"  # English (United States) input method ID
Set-WinUILanguageOverride -Language "en-US"
Set-WinDefaultInputMethodOverride -InputTip $inputMethod
Write-Output "The input method has been changed to English (United States)."
