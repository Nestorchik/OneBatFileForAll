import requests
import zipfile
import io
import os
import shutil

def download_repo(owner, repo, branch="master", dest="."):
    url = f"https://github.com/{owner}/{repo}/archive/refs/heads/{branch}.zip"
    print(f"Скачиваю компоненты ...")

    r = requests.get(url)
    r.raise_for_status()

    with zipfile.ZipFile(io.BytesIO(r.content)) as z:
        z.extractall(dest)

    extracted_folder = os.path.join(dest, f"{repo}-{branch}")
    target_folder = os.path.join(dest, repo)
    if os.path.exists(target_folder):
        shutil.rmtree(target_folder)

    shutil.move(extracted_folder, target_folder)

    print(f"Репозиторий скачан в: {target_folder}")
    return target_folder


if __name__ == "__main__":
    comfyui_path = download_repo("comfyanonymous", "ComfyUI", branch="master", dest=".")
    custom_nodes_dir = os.path.join(comfyui_path, "custom_nodes")
    os.makedirs(custom_nodes_dir, exist_ok=True)
    download_repo("ltdrdata", "ComfyUI-Manager", branch="main", dest=custom_nodes_dir)
