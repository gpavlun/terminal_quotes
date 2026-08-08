total_len = 0
with open("quotes.txt", "rb") as quote_file:
    quotes = quote_file.readlines()
with open("indices.idx", "wb") as index_file:
    for line in quotes:
        # print(line, len(line))
        size = total_len.to_bytes(8, byteorder="big", signed=False)
        index_file.write(size)
        total_len += len(line)
    index_file.write(len(quotes).to_bytes(8, byteorder="big", signed=False))
    # last line of indices.idx is number of quotes in quotes.txt
print("Done")
