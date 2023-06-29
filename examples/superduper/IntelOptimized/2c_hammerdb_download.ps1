
function download_hammerdb {
    Invoke-WebRequest -o Hammerdb.zip https://storage.googleapis.com/cbr_bucket_artifacts/Utils/Windows/HammerDB-4.2-Win.zip
    expand-archive -path '.\Hammerdb.zip' -destinationpath '.\HammerDB'
}

download_hammerdb