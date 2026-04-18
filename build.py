import zipfile
import os
import shutil
import subprocess

def create_jsdos_bundle():
    bundle_name = "turbocpp.jsdos"
    output_dir = "dist"
    
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)

    print(f"Creating {bundle_name} with aggressive compression...")
    # Using compressionlevel 9 for maximum shrinkage
    with zipfile.ZipFile(bundle_name, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as zipf:
        # Add .jsdos directory contents to the root of the zip
        for root, dirs, files in os.walk(".jsdos"):
            for file in files:
                filepath = os.path.join(root, file)
                arcname = os.path.relpath(filepath, ".jsdos")
                zipf.write(filepath, arcname)
        
        # Add prebuilts directory
        for root, dirs, files in os.walk("prebuilts"):
            for file in files:
                zipf.write(os.path.join(root, file))
        
        # Add README.md
        if os.path.exists("README.md"):
            zipf.write("README.md")

    # Move bundle to output dir
    shutil.move(bundle_name, os.path.join(output_dir, bundle_name))
    
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
