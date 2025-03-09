package com.saucelabs.challenge;

import org.jf.dexlib2.DexFileFactory;
import org.jf.dexlib2.Opcodes;
import org.jf.dexlib2.rewriter.DexRewriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Paths;

public class DexPatcher {

    private static final Logger log = LoggerFactory.getLogger(DexPatcher.class);

    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            throw new IllegalArgumentException("Usage: pass the path to the .dex file as the only argument.");
        }
        var path = Paths.get(args[0]);
        if (!path.toFile().exists()) {
            throw new IllegalArgumentException("Dex file at path '%s' does not exist.".formatted(path));
        }
        log.info("Patching dex file {}", path);
        var dex = DexFileFactory.loadDexFile(
                path.toFile(),
                Opcodes.getDefault()
        );

        var rewriter = new DexRewriter(
                new IngredientsRewritingModule()
        );

        var rewritten = rewriter
                .getDexFileRewriter()
                .rewrite(dex);

        log.info("Rewriting and replacing original dex file {}", path);
        DexFileFactory.writeDexFile(
                path.toAbsolutePath().toString(),
                rewritten
        );
    }
}
