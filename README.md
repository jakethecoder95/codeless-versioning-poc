# Codeless Versioning Strategy

## Introduction
The goal of this repository is to explore different approaches people are using for managing versioning. The goal of our system is to have a release pipeline that allows us to easily release versions across our environments. From dev to qa-test, staging, and finally production. We need a way to easily mark certain commits in our version control system as ready for each environment and move those artifacts between environments in a way that reduces waste and redundancy.

One win the team has pin-pointed is the possibility of removing redundant builds. Currently, in order to move a commit from our lower environments (qa-test and development) into staging, we have a process where we create a new release branch, remove the snapshot version from the build-info file, and remove the snapshot versions from our common libraries. Then we have typically manually triggered the release build on that branch from Jenkins. Although we have recently improved this process by introducing tab-based auto-builds, albeit the process remains mostly manual.

There are a few problems with the current approach.
1. The process introduces risk: This process introduces risk because the common java libraries are on snapshot versions. This means that the release build is possibly not going to be identical to the builds that were tested and approved in our lower environments because a new snapshot of the common library has been created since we last tested the service. This issue has affected us before and delayed release candidates from being cut. Fortunately we have caught it before production up until this point. However, it is possible that changes could get through staging and into production without being verified and tested.
2. The additional builds may be redundant: This really get's to the main point of the POC. When a service is marked as "ready for release candidate" in our lower environments, we mean that that specific version is ready for a release, do we really need to generate another artifact?

There is broad agreement that we need to move away from snapshot versioning for common libraries. So problem 1 above will be fixed by that. For the sake of brevity, for the rest of this document I'd like us to assume that problem is already solved and focus on the second. Let's pretend that we have already moved our common lib on to always use fixed SemVer versions. So now the question is, do we really need to go through the whole process of rebuilding our service when the only change we want to make is to the version in our build-info.yml file? Is a version a descriptor of a specific commit in our version control system or is it a part of the artifact itself. For this document, I'd like to explore the idea of removing the version from the artifact builds.

## Options

## HotFixes

## Pros/Cons

### Cons
- The version is not available to be used inside the codebase so it cannot be displayed to external entities. Self-referencing the version inside the code may be important

## Conclusion

## Sources
1. https://www.reddit.com/r/devops/comments/sop8xp/versioningrelease_management_strategy/
2. https://git-scm.com/docs/git-describe
3. https://stackoverflow.com/questions/33821137/build-versioning-in-continuous-delivery
4. https://stackoverflow.com/questions/55416379/how-to-avoid-keeping-version-number-in-source-code
5. Example of a codebase without "in-code" versioning: https://github.com/drawdb-io/drawdb
