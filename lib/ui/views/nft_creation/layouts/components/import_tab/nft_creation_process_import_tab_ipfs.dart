/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabIPFS extends ConsumerWidget {
  const NFTCreationProcessImportTabIPFS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    return InkWell(
      onTap: () async {
        await context.push(
          NFTCreationProcessImportTabIPFSForm.routerPage,
          extra: {
            'onConfirm': (uri) {
              nftCreationNotifier.setContentIPFSProperties(
                context,
                uri,
              );
            },
          },
        );
      },
      child: SizedBox(
        height: 50,
        child: SheetDetailCard(
          children: [
            const Icon(UiIcons.ipfs_icon, size: 20),
            const SizedBox(width: 3),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizations.nftAddImportIPFS,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
