
package io.jenkins.plugins.ml;

import org.apache.zeppelin.interpreter.InterpreterException;
import org.apache.zeppelin.interpreter.InterpreterResultMessage;

import java.io.IOException;
import java.util.List;

/**
 * Interface for Kernel Interpreter (Eg: IPython ,R and Julia).
 */

public interface KernelInterpreter {

    List<InterpreterResultMessage> interpretCode(String code) throws IOException, InterpreterException;

    void start() throws InterpreterException;

    void shutdown() throws InterpreterException;

}
