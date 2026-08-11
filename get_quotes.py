#!/usr/bin/env python3
from pathlib import Path
import random
from shutil import get_terminal_size as get_terminal_size
import textwrap
# get directory where this script is
BASE_DIR = Path(__file__).resolve().parent
QUOTE_FILE = BASE_DIR / "quotes.txt"
INDEX_FILE = BASE_DIR / "indices.idx"

def random_line(quote_file, index_file):
    with open(index_file, "rb") as i:
        # first, get the number of possible quotes
        i.seek(-8, 2)
        size = i.read(8)
        quotes = int.from_bytes(size, byteorder="big", signed=False)
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

if __name__ == "__main__":
    quote = random_line(QUOTE_FILE, INDEX_FILE)
    # get width of terminal; assume 80 if can't get answer
    terminal_width = get_terminal_size(fallback=(80, 24)).columns
    # wrap quote so no words wrapped across multiple lines
    wrapped_quote = textwrap.fill(quote, width=terminal_width)
    print(wrapped_quote)
