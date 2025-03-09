package com.saucelabs.challenge;

import org.jf.dexlib2.iface.Method;
import org.jf.dexlib2.iface.MethodImplementation;
import org.jf.dexlib2.immutable.ImmutableMethod;
import org.jf.dexlib2.rewriter.*;

/**
 * The rewriting module steps through every single class, method, instruction etc. of a .dex file.
 * It allows to either modify (rewrite) those definitions, or keep them their original state otherwise.
 */
public class IngredientsRewritingModule extends RewriterModule {

    @Override
    public Rewriter<Method> getMethodRewriter(Rewriters rewriters) {
        return new MethodRewriter(rewriters) {
            @Override
            public Method rewrite(Method method) {
                if (isTheMethodFaulty(method)) {
                    return new ImmutableMethod(
                            method.getDefiningClass(),
                            method.getName(),
                            method.getParameters(),
                            method.getReturnType(),
                            method.getAccessFlags(),
                            method.getAnnotations(),
                            method.getHiddenApiRestrictions(),
                            patchImplementation(method.getImplementation())
                    );
                }
                return super.rewrite(method);
            }

            private boolean isTheMethodFaulty(Method method) {
                // Write the logic to identify if the current method has the faulty code, and return a boolean accordingly.
                return false;
            }
        };
    }

    private MethodImplementation patchImplementation(MethodImplementation implementation) {
        // Find and fix the instruction to correct the logic, and return the updated MethodImplementation.
        return implementation;
    }
}
