total_len = 0
quote_count = 0

with open("quotes.txt", "rb") as quote_file, open("indices.idx", "wb") as index_file:
    for line in quote_file:
        index_file.write(total_len.to_bytes(8, byteorder="big", signed=False))
        total_len += len(line)
        quote_count += 1

    index_file.write(quote_count.to_bytes(8, "big"))
    # last line of indices.idx is number of quotes in quotes.txt

print("Done")
