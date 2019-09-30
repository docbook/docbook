# It's a terrible hack to use Make to run gradle, but I can't
# figure out how to make gradle subprojects run in the appropriate
# current directory. Perhaps that's bad design, but making the
# whole build system agnostic to the current working directory
# looks like a real mess.

all:
	cd relaxng/schemas && ./gradlew dist
	cd xmlschema/schemas && ./gradlew

clean:
	cd relaxng/schemas && ./gradlew clean
	cd xmlschema/schemas && ./gradlew clean

