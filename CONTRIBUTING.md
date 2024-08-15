# Contributing

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing to Archethic Wallet which is hosted in the [Archethic Foundation](https://github.com/archethic-foundation) on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

#### Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Enhancements](#suggesting-enhancements)
  * [Your First Code Contribution](#your-first-code-contribution)
  * [Pull Requests](#pull-requests)
     * [Git Commit Messages](#git-commit-messages)
  * [Code architecture](#code-architecture)


## Code of Conduct

This project and everyone participating in it is governed by the [Archethic code of conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## I don't want to read this whole thing I just have a question!!!

> **Note:** Please don't file an issue to ask a question.

We have an official message board with a detailed FAQ and where the community chimes in with helpful advice if you have questions.

* [Github Discussions](https://github.com/archethic-foundation/archethic_wallet/discussions)
* [Archethic Website](https://archethic.net)

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for Archethic Wallet. Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

Before creating bug reports, please check [this list](#before-submitting-a-bug-report) as you might find out that you don't need to create one. When you are creating a bug report, please [include as many details as possible](#how-do-i-submit-a-good-bug-report). Fill out [the required template](https://github.com/archethic-foundation/.github/blob/master/.github/ISSUE_TEMPLATE/bug_report.yml), the information it asks for helps us resolve issues faster.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### Before Submitting A Bug Report

* **Check the [discussions](https://github.com/archethic-foundation/archethic_wallet/discussions)** for a list of common questions and problems.
* **Check the [issue list](https://github.com/archethic-foundation/archethic_wallet/issues)** if it has been already opened.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as [GitHub issues](https://guides.github.com/features/issues/) and create an issue on that repository and provide the following information by filling in [the template](https://github.com/archethic-foundation/.github/blob/main/.github/ISSUE_TEMPLATE/bug_report.yml).

Explain the problem and include additional details to help maintainers reproduce the problem:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. When listing steps, **don't just say what you did, but explain how you did it**.
* **Provide specific examples to demonstrate the steps**. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **If you're reporting a crash**, include a crash report with a stack trace. nclude the crash report in the issue in a [code block](https://help.github.com/articles/markdown-basics/#multiple-lines), a [file attachment](https://help.github.com/articles/file-attachments-on-issues-and-pull-requests/), or put it in a [gist](https://gist.github.com/) and provide link to that gist.
* **If the problem is related to performance or memory**, include a screenshot of the `observer`
* **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

Provide more context by answering these questions:

* **Did the problem start happening recently** (e.g. after updating to a new version) or was this always a problem?
* If the problem started happening recently, **can you reproduce the problem in an older version of the wallet?** What's the most recent version in which the problem doesn't happen?
* **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Archethic Wallet, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please check [this list](#before-submitting-an-enhancement-suggestion) as you might find out that you don't need to create one. When you are creating an enhancement suggestion, please [include as many details as possible](#how-do-i-submit-a-good-enhancement-suggestion). Fill in [the template](https://github.com/archethic-foundation/.github/blob/master/.github/ISSUE_TEMPLATE/feature_request.yml), including the steps that you imagine you would take if the feature you're requesting existed.

#### How Do I Submit A (Good) Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](https://guides.github.com/features/issues/) and create an issue on that repository and provide the following information:

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a detailed description of the suggested enhancement** in as many details as possible.
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Explain why this enhancement would be useful** .

### Your First Code Contribution

Unsure where to begin contributing to Atom? You can start by looking through these `beginner` and `help-wanted` issues:

* [Beginner issues][beginner] - issues which should only require a few lines of code, and a test or two.
* [Help wanted issues][help-wanted] - issues which should be a bit more involved than `beginner` issues.

Both issue lists are sorted by total number of comments. While not perfect, number of comments is a reasonable proxy for impact a given change will have.

### Pull Requests

The process described here has several goals:

- Maintain Archethic Wallet's quality
- Fix problems that are important
- Enable a sustainable system for Archethic's maintainers to review contributions

#### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line
* Consider starting the commit message with an applicable emoji:
    * :art: `:art:` when improving the format/structure of the code
    * :racehorse: `:racehorse:` when improving performance
    * :non-potable_water: `:non-potable_water:` when plugging memory leaks
    * :memo: `:memo:` when writing docs
    * :bug: `:bug:` when fixing a bug
    * :fire: `:fire:` when removing code or files
    * :white_check_mark: `:white_check_mark:` when adding tests
    * :lock: `:lock:` when dealing with security
    * :arrow_up: `:arrow_up:` when upgrading dependencies
    * :arrow_down: `:arrow_down:` when downgrading dependencies
    * :shirt: `:shirt:` when removing linter warnings

## Code architecture

A migration to hexagonal architecture is ongoing. We describe here the target architecture.

### Big picture

Application is composed of 4 layers. Here is the folder structure matching each layers :

  - **domain :** Core data structures and logic. Everything in here is third party component agnostic.
    - **models :** Data structures.
    - **repositories :** Interfaces describing interactions with **models**.
    - **usecases :** Complex use cases implementation.
  - **ui :** All the display/user-interaction components
  - **application :** Business logic components.
  - **infrastructure :** This is the **domain/repositories** implementations. All third party SDK/API dependent code should end up here.

### Layers role & interactions

Rather than reinventing the wheel, I encourage you to check [this excellent diagram from resocoder.com](https://resocoder.com/wp-content/uploads/2020/03/DDD-Flutter-Diagram-v3.svg) out.

### Libraries / Technical choices

- **Application state management** heavily relies on [Riverpod](https://riverpod.dev/).
- **Dependency injection** relies on [Riverpod](https://riverpod.dev/) too. There is still a non neglectable part using the excellent [GetIt](https://pub.dev/packages/get_it) library.
- **Blockchain interaction** is extracted to the [archethic_lib_dart](https://pub.dev/packages/archethic_lib_dart) package.


### DApp | RPC Server structure

In order to allow DApps to interact with Archethic Wallet, an RPC server is running.

RPC server implementation depends on the host platform capabilities :
  - a `Websocket` server on **Web**, **Windows**, **MacOS** and **GNU/Linux**
  - a `DeeplinkRPC` "server" on **iOS** and **Android**.

Some RPC commands require user explicit validation. Because of that, we need to handle RPC Commands on the **UI** layer.

```
                                         │             INFRASTRUCTURE             │            DOMAIN           │          PRESENTATION / UI
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                         │                                        │                             │
                                                                                                                │
                            Deeplink request    ┌──────────────────────────────┐   Result                       │
                       ┌───────────────────────►│                              │◄────┐                          │
┌──────────┐           │                        │  ArchethicDeeplinkRPCServer  │     │  ┌───────────────────┐   │
│          ├───────────┘  ┌─────────────────────┤                              ├──┐  └──┤                   │   │
│          │              │                     └──────────────────────────────┘  │     │                   │        ┌────────────────────┐    ┌───────────┐
│          │◄─────────────┘                                                       └────►│                   ├───────►│                    ├────┘           ▼
│   DApp   │                                                                  Command   │ CommandDispatcher │        │ RPCCommandReceiver │           performs action
│          │◄─────────────┐                                                       ┌────►│                   │◄───────┤                    │◄───┐           │
│          │              │                                                       │     │                   │        └────────────────────┘    └───────────┘
│          ├───────────┐  │                     ┌───────────────────────────────┐ │  ┌──┤                   │   │
└──────────┘           │  └─────────────────────┤                               ├─┘  │  └───────────────────┘   │
                       │                        │  ArchethicWebsocketRPCServer  │    │                          │
                       └────────────────────────┤                               │◄───┘                          │
                           WebSocket request    └───────────────────────────────┘  Result                       │
                                                                                                                │
                                          │                                        │                            │
                                          │                                        │                            │
```




## Tools

### Translations

- By default, the application is in **English**.

- All texts (labels, messages, ...) must be written in files ``lib/intl_en.arb`` and ``lib/intl_fr.arb``.

- To get the labels in the widgets, you have to use ```final localizations = AppLocalizations.of(context)!;``` then retrieve the value of the label with its key.

All information about internationalization with Flutter is available in the [official documentation](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
 
### Riverpod generator

- To start the code generator, run the following command: ``run build_runner watch``. See [Riverpod generator documentation](https://pub.dev/packages/riverpod_generator)

### Icons

We are using the icons from google, material icons : https://fonts.google.com/icons

#### Icons generator
- To convert all svg icons from ``assets/fonts`` folder, run the following command : ``icon_font_generator --from=assets/icons/menu --class-name=UiIcons --out-font=assets/fonts/ui_icons.ttf --out-flutter=lib/ui/widgets/components/icons.dart``. See [Icon Font Generator documentation](https://pub.dev/packages/icon_font_generator)


## Data storage
**Wallet** data are stored using [Hive](https://docs.hivedb.dev/). 

Storage **Boxes** are split into  categories :
 - **Raw boxes :** Those boxes contain non-sensitive data
 - **Vaults :** those boxes are [encrypted Hive boxes](https://docs.hivedb.dev/#/advanced/encrypted_box)
    - **Web platform :** to mitigate lack of [**FlutterSecureStorage**](https://pub.dev/packages/flutter_secure_storage) on web platform, the **Box Encryption Key** is itself encrypted using user password.
    - **Other platforms :** the **Box Encryption Key** is stored in the system [**FlutterSecureStorage**](https://pub.dev/packages/flutter_secure_storage)
 - **Encrypted boxes :** these boxes are used on **non web platforms** only. They store user **Pin** or **Password** code

 ### Raw boxes

 - **[_preferencesBox](./lib/infrastructure/datasources/preferences.hive.dart)** : User settings
 - **[tokensListBox](./lib/infrastructure/datasources/tokens_list.hive.dart)** : Cache for [Tokens](./lib/infrastructure/datasources/wallet_token_dto.hive.dart) read from API
 - **[contacts](./lib/infrastructure/datasources/contacts.hive.dart)** : User registered [Contacts](./lib/model/data/contact.dart)
 - **[appWallet](./lib/infrastructure/datasources/appwallet.hive.dart)** : Non-sensitive [Wallet data](./lib/domain/models/app_wallet.dart)
 - **[price](./lib/infrastructure/datasources/price.hive.dart)** : Cache for currency [Prices](./lib/model/data/price.dart) read from Oracle

### Vault

- **[_vaultBox](./lib/infrastructure/datasources/keychain_info.vault.dart)** : Sensitive data
    - keychain seed
    - [KeychainSecuredInfos](./lib/model/blockchain/keychain_secured_infos.dart)
- **[CacheManagerHive](./lib/util/cache_manager_hive.dart)**: Blockchain cache for various data
    - Token images data
- **[NotificationsSetup](./lib/infrastructure/datasources/notification.vault.dart)** : [Push notification data](./lib/model/data/notification_setup_dto.dart)

### Encrypted boxes

- **[NonWebAuthentication](./lib/infrastructure/datasources/authent_nonweb.secured_hive.dart)** : User authentication data (pin/password)
