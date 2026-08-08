import random

def random_line(quote_file, index_file):
    with open(index_file, "rb") as i:
        # first, get the number of possible quotes
        i.seek(-8, 2)
        size = i.read(8)
        quotes = int.from_bytes(size, byteorder="big", signed=False)
        if (quotes == 0):
            # no quotes in file would cause later steps to crash
            raise ValueError("quotes file has no quotes")
        # then chose a random quote to go get
        target = random.randrange(0, quotes)
        # figure out where in the quote file it is
        i.seek(8*target, 0)
        quote_index = int.from_bytes(i.read(8), byteorder="big", signed=False)

    # get the quote
    with open(quote_file, "rb") as f:
        f.seek(quote_index, 0)
        quote = f.readline().decode("utf-8")

    return quote

print(random_line("quotes.txt", "indices.idx"))
