import random

def random_line(quote_file, index_file):
    with open(index_file, "rb") as i:
        i.seek(-8, 2)
        size = i.read(8)
        quotes = int.from_bytes(size, byteorder="big", signed=False)
        target = random.randrange(0, quotes)
        i.seek(8*target, 0)
        quote_index = int.from_bytes(i.read(8), byteorder="big", signed=False)

    with open(quote_file, "rb") as f:
        f.seek(quote_index, 0)
        quote = f.readline().decode("utf-8")

    return quote

print(random_line("quotes.txt", "indices.idx"))
