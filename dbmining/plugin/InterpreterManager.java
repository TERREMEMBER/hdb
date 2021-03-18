
package io.jenkins.plugins.ml;

import org.apache.zeppelin.interpreter.InterpreterException;

import java.io.Closeable;
import java.io.IOException;

/**
 * Abstract class that can be subclassed for individual interpreter management
 */

public abstract class InterpreterManager implements Closeable {

    abstract KernelInterpreter createInterpreter();
    abstract void initiateInterpreter() throws InterpreterException;
    abstract void closeInterpreter();
    abstract boolean testConnection() throws IOException, InterpreterException;

    protected String invokeInterpreter(String code) throws IOException, InterpreterException {
        KernelInterpreter kernelInterpreter = createInterpreter();
        return kernelInterpreter.interpretCode(code).toString();
    }
}
