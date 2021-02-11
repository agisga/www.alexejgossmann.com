import os

author_str = "author: Alexej Gossmann\n"
os.chdir("/home/alexej/github/www.alexejgossmann.com/_posts")
posts_list = os.listdir("./")
posts_list = [post for post in posts_list if post.endswith(".md")]

for post in posts_list:
    print(f"Working on {post}...")

    f = open(post, "r")
    lines = f.readlines()
    f.close()
    lines_it = iter(lines)
    front_matter = []
    tripple_dash = 0
    while (tripple_dash < 2):
        front_matter.append(next(lines_it))
        if "---" in front_matter[-1]:
            tripple_dash += 1
    title_idx = None
    author_idx = None
    for i, line in enumerate(front_matter):
        if str.lower(line).startswith("author"):
            author_idx = i
        if str.lower(line).startswith("title"):
            title_idx = i

    if author_idx is None:
        lines.insert(title_idx+1, author_str)

    f = open(post, "w")
    lines = "".join(lines)
    f.write(lines)
    f.close()
