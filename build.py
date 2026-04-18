import os
import shutil
import subprocess

def create_jsdos_bundle():
    bundle_name = "turbocpp.jsdos"
    output_dir = "dist"
    
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)

    print(f"Creating {bundle_name} with exact original structure...")
    
    stage_dir = "temp_stage"
    if os.path.exists(stage_dir):
        shutil.rmtree(stage_dir)
    os.makedirs(stage_dir)

    # 1. Copy .jsdos folder (preserving the name)
    if os.path.exists(".jsdos"):
        shutil.copytree(".jsdos", os.path.join(stage_dir, ".jsdos"))
        # ALSO copy dosbox.conf and jsdos.json to the root for JS-DOS boot
        shutil.copy2(".jsdos/dosbox.conf", os.path.join(stage_dir, "dosbox.conf"))
        shutil.copy2(".jsdos/jsdos.json", os.path.join(stage_dir, "jsdos.json"))

    # 2. Copy prebuilts folder exactly as is
    if os.path.exists("prebuilts"):
        shutil.copytree("prebuilts", os.path.join(stage_dir, "prebuilts"))

    # 3. Copy README.md
    if os.path.exists("README.md"):
        shutil.copy2("README.md", os.path.join(stage_dir, "README.md"))

    # Zip everything in stage_dir
    try:
        # Use system zip to ensure all metadata/folders are preserved correctly
        subprocess.run(["zip", "-9", "-r", f"../{bundle_name}", "."], cwd=stage_dir, check=True)
    except Exception as e:
        print(f"Zip failed: {e}")
        shutil.make_archive("turbocpp", 'zip', stage_dir)
        os.rename("turbocpp.zip", bundle_name)

    # Move bundle to output dir
    shutil.move(bundle_name, os.path.join(output_dir, bundle_name))
    
    # Cleanup stage
    shutil.rmtree(stage_dir)
    
    # Run Tailwind build
    print("Running Tailwind build...")
    try:
        subprocess.run(["bun", "run", "build:css"], check=True)
    except Exception as e:
        print(f"Tailwind build failed: {e}")

    # Copy index.html and assets to output dir
    if os.path.exists("index.html"):
        shutil.copy("index.html", os.path.join(output_dir, "index.html"))
    
    # Copy assets if they exist
    for asset in ["favicon.ico", "manifest.json", "turboc.png"]:
        if os.path.exists(asset):
            shutil.copy(asset, os.path.join(output_dir, asset))
            
    print(f"Build complete. Files are in {output_dir}")

if __name__ == "__main__":
    create_jsdos_bundle()
