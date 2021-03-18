
package io.jenkins.plugins.ml;

import com.cloudbees.hudson.plugins.folder.AbstractFolder;
import com.cloudbees.hudson.plugins.folder.AbstractFolderProperty;
import hudson.model.ItemGroup;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Provides folder level configuration.
 */
public class ServerFolderProperty extends AbstractFolderProperty<AbstractFolder<?>> {
    /**
     * Hold the servers configuration.
     */
    private List<Server> servers = Collections.emptyList();

    /**
     * Constructor.
     */
    public ServerFolderProperty() {
    }

    /**
     * Return the IPython servers.
     *
     * @return the IPython servers
     */
    public Server[] getServer() {
        return servers.toArray(new Server[0]);
    }

    public void setServers(List<Server> Servers) {
        this.servers = Servers;
    }

    /*
    * Return list of servers from folders
     */
    static List<Server> getServersFromFolders(ItemGroup itemGroup) {
        List<Server> result = new ArrayList<>();
        while (itemGroup instanceof AbstractFolder<?>) {
            AbstractFolder<?> folder = (AbstractFolder<?>) itemGroup;
            ServerFolderProperty serverFolderProperty = folder.getProperties()
                    .get(ServerFolderProperty.class);
            if (serverFolderProperty != null && serverFolderProperty.getServer().length != 0) {
                result.addAll(Arrays.asList(serverFolderProperty.getServer()));
            }
            itemGroup = folder.getParent();
        }
        return result;
    }
}
